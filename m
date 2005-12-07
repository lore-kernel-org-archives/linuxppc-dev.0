Return-Path: <rdreier@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3-in.cisco.com [171.71.176.72])
	by ozlabs.org (Postfix) with ESMTP id D1DAE68866
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Dec 2005 16:21:00 +1100 (EST)
To: "Ruslan V. Sushko" <rsushko@ru.mvista.com>
References: <1133873391.16347.42.camel@mephisto.spb.rtsoft.ru>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 06 Dec 2005 21:17:42 -0800
In-Reply-To: <1133873391.16347.42.camel@mephisto.spb.rtsoft.ru> (Ruslan V.
	Sushko's message of "Tue, 06 Dec 2005 15:49:51 +0300")
Message-ID: <ada3bl5pjt5.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2/5] ppc32: verbose error checking for Yucca PCIE
 initialization
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    Ruslan> I haven't saw any error but this is potential issue
    Ruslan> because this flag asserts only then PCI Express port
    Ruslan> initialization is completed. I guess the initialization
    Ruslan> sequences assumes time using. Therefore the error may
    Ruslan> appears in future revision of the boards if Core clock
    Ruslan> will grow up.  Nevertheless I do not know the time which
    Ruslan> is necessary for completeness, so I add this just to be
    Ruslan> safe.

Hmm, I guess this is OK.  Matt, go ahead and apply this.

 - R.
