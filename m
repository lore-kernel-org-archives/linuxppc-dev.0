Return-Path: <adams.ppc@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 5113EDDF4A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Aug 2008 06:53:06 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so82969ywh.39
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Aug 2008 13:53:03 -0700 (PDT)
Message-ID: <4a21eaea0808291353p29992a2che64854f93829d706@mail.gmail.com>
Date: Fri, 29 Aug 2008 14:53:03 -0600
From: "bhanu jampala" <adams.ppc@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: How many super channels per TDM on MCC
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, rmcguire@videopresence.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Guys,

This is regarding MCC controller on MPC8260.
I am having problems figuring out how super channels fit into a TDM.

A superchannel is the combination of multiple MCC TX channels' FIFOs and one
set of an MCC channel's parameters and buffer descriptors.

If I want to support 24 super channels with 4 timeslots each.
Can I use a single TDM (i.e. from A,B ,C, D) to accomplish this task.
(each TDM has 32 timeslots).

- Mukund Jampala
