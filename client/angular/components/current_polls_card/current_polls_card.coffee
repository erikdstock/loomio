Records        = require 'shared/services/records.coffee'
AbilityService = require 'shared/services/ability_service.coffee'

angular.module('loomioApp').directive 'currentPollsCard', (LoadingService, ModalService) ->
  scope: {model: '='}
  templateUrl: 'generated/components/current_polls_card/current_polls_card.html'
  controller: ($scope) ->
    $scope.fetchRecords = ->
      Records.polls.fetchFor($scope.model, status: 'active')
    LoadingService.applyLoadingFunction $scope, 'fetchRecords'
    $scope.fetchRecords()

    $scope.polls = ->
      _.take $scope.model.activePolls(), ($scope.limit or 50)

    $scope.startPoll = ->
      ModalService.open 'PollCommonStartModal', poll: -> Records.polls.build(groupId: $scope.model.id)

    $scope.canStartPoll = ->
      AbilityService.canStartPoll($scope.model.group())