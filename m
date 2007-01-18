Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id E411FDDE26
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Jan 2007 17:20:15 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so93395ugf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Jan 2007 22:20:13 -0800 (PST)
Message-ID: <528646bc0701172220l7ce35a1cl2d8829b550cedd57@mail.gmail.com>
Date: Wed, 17 Jan 2007 23:20:13 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Bruce_Leonard@selinc.com" <Bruce_Leonard@selinc.com>
Subject: Re: Who's the maintainer for the freescale MPC8349ITX board?
In-Reply-To: <OF27AFB204.D453295B-ON88257267.0011100B-88257267.00158710@selinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <71718296-E8FC-48B0-9A8E-F2F54373C94E@kernel.crashing.org>
	<OF27AFB204.D453295B-ON88257267.0011100B-88257267.00158710@selinc.com>
Cc: linuxppc-embedded-bounces+brucle=selinc.com@ozlabs.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 1/17/07, Bruce_Leonard@selinc.com <Bruce_Leonard@selinc.com> wrote:
> I'm trying to bring up the
> 2.6.19.1 kernel using u-boot 1.1.6 on the MPC8349ITX board and I'm having
> problems with the open firmware part of it (which I am TOTALLY new to).
> Short version, I don't think the *.dts file for this board is correct and
> I'm wondering if anyone might have a newer version or good documentation
> as to the formatting of the *.dts files?

There is some device tree documentation in the kernel tree:
Documentation/powerpc/booting-without-of.txt

Also, make sure you're either using the latest dtc;  If not, then you
need to use the '-V 0x10' switch to get the correct tree format.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
