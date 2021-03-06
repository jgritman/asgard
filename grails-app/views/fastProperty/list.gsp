<%--

    Copyright 2012 Netflix, Inc.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <title>Fast Properties</title>
</head>

<body>
<div class="body">
  <h1>Fast Properties in platformservice in ${region.description}</h1>
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <g:form method="post">
    <div class="buttons">
      <g:link class="create" action="create">Create New Fast Property</g:link>
    </div>
    <div class="list">
      <table class="sortable fastProperties">
        <thead>
        <tr>
          <th>Application</th>
          <th>Env</th>
          <th class="sorttable_alpha">Property</th>
          <th class="sorttable_alpha">Value</th>
          <th>Timestamp</th>
          <th class="sorttable_alpha">Updated By</th>
          <th class="sorttable_alpha">Source</th>
          <th>Region</th>
          <th class="sorttable_alpha">Stack</th>
          <th class="sorttable_alpha">Countries</th>
          <th class="sorttable_alpha">${ticketLabel.encodeAsHTML()}</th>
        </tr>
        </thead>
        <tbody>
        <g:each var="fastProperty" in="${fastProperties}" status="i">
          <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
            <td class="app"><g:linkObject type="application" name="${fastProperty?.appId?.toLowerCase()}">${fastProperty?.appId}</g:linkObject></td>
            <td>${fastProperty?.env}</td>
            <td class="propKey"><g:linkObject type="fastProperty" name="${fastProperty?.id}">${fastProperty?.key}</g:linkObject></td>
            <td class="propValue">${fastProperty?.value?.encodeAsHTML()}</td>
            <td>${fastProperty?.ts}</td>
            <td class="updatedBy">${fastProperty?.updatedBy?.encodeAsHTML()}</td>
            <td class="sourceOfUpdate">${fastProperty?.sourceOfUpdate?.encodeAsHTML()}</td>
            <td>${fastProperty?.region}</td>
            <td class="var">${fastProperty?.stack?.encodeAsHTML()}</td>
            <td class="var">${fastProperty?.countries?.encodeAsHTML()}</td>
            <td class="var">${fastProperty?.cmcTicket?.encodeAsHTML()}</td>
          </tr>
        </g:each>
        </tbody>
      </table>
    </div>

    <div class="paginateButtons">
    </div>
  </g:form>
</div></body>
</html>
