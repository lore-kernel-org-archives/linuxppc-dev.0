Return-Path: <aubrey1127@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.202])
	by ozlabs.org (Postfix) with ESMTP id 9BEA22BF12
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 21:00:15 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 36so684269wra
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 02:00:14 -0800 (PST)
Message-ID: <7f834d4e050113020078cf9c88@mail.gmail.com>
Date: Thu, 13 Jan 2005 18:00:14 +0800
From: Aubrey Lee <aubrey1127@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: About zebra Error
Reply-To: Aubrey Lee <aubrey1127@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    Hi, now I know what the problem is.
    For my case, the ppc-linux kernel should be configured as the following:
    The Item [Unix domain Socket]  should be selected [Y]
    Just so so.
