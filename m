Return-Path: <mgessner@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 54F8EDE816
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 06:32:45 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 3so177090ywj.39
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 13:32:44 -0700 (PDT)
Message-ID: <85a5c2010803311332l6be71466n9826070caf725abd@mail.gmail.com>
Date: Mon, 31 Mar 2008 16:32:43 -0400
From: "Matt Gessner" <mgessner@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: cpm2.c error in cpm2_clk_setup
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I found what I think is an error while looking at the above function,
in the kernel pull from v2.6.25-rc7, today.

The switch(target) contains a case CPM_CLK_SCC1 that sets reg and
shift, and then falls through to teh CPM_CLK_SCC2 case.

I'm not active in this project; I was simply looking at some code
trying to find something, and stumbled across it.

I'm bringing this to the list's attention because I have no way to
test this, but it sure looks like an error.

HTH,

Regards,

Matt Gessner
