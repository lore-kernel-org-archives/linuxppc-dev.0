Return-Path: <jlarrew@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9C690B72DE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 10 May 2011 07:26:37 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p49LF9Hj011653
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 May 2011 15:15:09 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	p49LQQ6P150166
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 May 2011 15:26:26 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p49FQO6G019071
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 May 2011 09:26:25 -0600
Message-ID: <4DC85BFE.7060900@linux.vnet.ibm.com>
Date: Mon, 09 May 2011 16:26:22 -0500
From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [BUG] rebuild_sched_domains considered dangerous
References: <1299639487.22236.256.camel@pasglop>
	<1299665998.2308.2753.camel@twins>
	<1299675674.2308.2924.camel@twins>
	<1299766211.2308.4468.camel@twins>
	<1303294056.8345.122.camel@twins>
	<1303336869.2513.26.camel@pasglop>
In-Reply-To: <1303336869.2513.26.camel@pasglop>
Content-Type: multipart/alternative;
	boundary="------------050809090000080802010600"
Cc: Peter Zijlstra <peterz@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050809090000080802010600
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/20/2011 05:01 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2011-04-20 at 12:07 +0200, Peter Zijlstra wrote:
>> On Thu, 2011-03-10 at 15:10 +0100, Peter Zijlstra wrote:
>>>
>>> Also, still waiting to hear from the Power7 folks on how often
>>> they think to rebuild the topology and how they think that makes
>>> sense, afaict Power7 does have actual NUMA nodes unlike s390, so
>>> I'm still not seeing how that's going to work properly at all.
>>
>> Jesse care to answer? I hear from Ben you're responsible for that
>> mess.
>
> "responsible for this mess" is a big word :-)
>
> But he's the one to last play with that code ... Jesse ?
>

Hi Peter!

According the the Power firmware folks, updating the home node of a virtual cpu happens rather infrequently. The VPHN code currently checks for topology updates every 60 seconds, but we can poll less frequently if it helps. I chose 60 second intervals simply because that's how often they check the topology on s390. ;-)

As for updating the memory topology, there are cases where changing the home node of a virtual cpu doesn't affect the memory topology. If it does, there is a separate notification system for memory topology updates that is independent from the cpu updates. I plan to start working on a patch set to enable memory topology updates in the kernel in the coming weeks, but I wanted to get the cpu patches out on the list so we could start having these debates. :)

Sincerely,

Jesse Larrew
Software Engineer, Linux on Power Kernel Team
IBM Linux Technology Center
Phone: (512) 973-2052 (T/L: 363-2052)
jlarrew@linux.vnet.ibm.com


--------------050809090000080802010600
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
    <title></title>
  </head>
  <body bgcolor="#ffffff" text="#000000">
    On 04/20/2011 05:01 PM, Benjamin Herrenschmidt wrote:<br>
    <span style="white-space: pre;">&gt; On Wed, 2011-04-20 at 12:07
      +0200, Peter Zijlstra wrote:<br>
      &gt;&gt; On Thu, 2011-03-10 at 15:10 +0100, Peter Zijlstra wrote:<br>
      &gt;&gt;&gt; <br>
      &gt;&gt;&gt; Also, still waiting to hear from the Power7 folks on
      how often<br>
      &gt;&gt;&gt; they think to rebuild the topology and how they think
      that makes<br>
      &gt;&gt;&gt; sense, afaict Power7 does have actual NUMA nodes
      unlike s390, so<br>
      &gt;&gt;&gt; I'm still not seeing how that's going to work
      properly at all.<br>
      &gt;&gt; <br>
      &gt;&gt; Jesse care to answer? I hear from Ben you're responsible
      for that<br>
      &gt;&gt; mess.<br>
      &gt; <br>
      &gt; "responsible for this mess" is a big word :-)<br>
      &gt; <br>
      &gt; But he's the one to last play with that code ... Jesse ?<br>
      &gt; <br>
    </span><br>
    Hi Peter!<br>
    <br>
    According the the Power firmware folks, updating the home node of a
    virtual cpu happens rather infrequently. The VPHN code currently
    checks for topology updates every 60 seconds, but we can poll less
    frequently if it helps. I chose 60 second intervals simply because
    that's how often they check the topology on s390. ;-)<br>
    <br>
    As for updating the memory topology, there are cases where changing
    the home node of a virtual cpu doesn't affect the memory topology.
    If it does, there is a separate notification system for memory
    topology updates that is independent from the cpu updates. I plan to
    start working on a patch set to enable memory topology updates in
    the kernel in the coming weeks, but I wanted to get the cpu patches
    out on the list so we could start having these debates. :)<br>
    <br>
    Sincerely,<br>
    <br>
    Jesse Larrew<br>
    Software Engineer, Linux on Power Kernel Team<br>
    IBM Linux Technology Center<br>
    Phone: (512) 973-2052 (T/L: 363-2052)<br>
    <a class="moz-txt-link-abbreviated" href="mailto:jlarrew@linux.vnet.ibm.com">jlarrew@linux.vnet.ibm.com</a><br>
    <br>
  </body>
</html>

--------------050809090000080802010600--
