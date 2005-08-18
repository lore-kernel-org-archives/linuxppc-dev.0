Return-Path: <smiling_23@nerdshack.com>
Received: from karen.nerdshack.com (karen.nerdshack.com [209.189.235.41])
	by ozlabs.org (Postfix) with ESMTP id BFC1E680A6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Aug 2005 16:34:53 +1000 (EST)
Received: from dispatchd.nerdshack.com (julie.nerdshack.com [209.189.235.39])
	by karen.nerdshack.com (Postfix) with SMTP id E681E1E38C8
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Aug 2005 00:59:28 -0500 (CDT)
Message-ID: <430513DD.1080108@nerdshack.com>
Date: Thu, 18 Aug 2005 23:03:57 +0000
From: smiling_23 <smiling_23@nerdshack.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Timer modification
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,
         Can any one know how the "timer_adj" calculation is working in 
timer.c in linuxkernle2.6.12.5
If we change the HZ value to more than 1000. What hapens to the wall clock.
And  i have seen different "time_adj" calculations for HZ 100 and 1000. 
How to change this calculation for new HZ value.
Thanks,
Cjag
