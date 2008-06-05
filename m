Return-Path: <matvejchikov@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 46E8FDE841
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Jun 2008 05:04:52 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so392372ywh.39
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 05 Jun 2008 12:04:45 -0700 (PDT)
Message-ID: <8496f91a0806051204w619eed31uee4feb812702707b@mail.gmail.com>
Date: Thu, 5 Jun 2008 23:04:39 +0400
From: "Matvejchikov Ilya" <matvejchikov@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: The 2.6.25 kernel dosen't run on pq2fads based board
In-Reply-To: <8496f91a0806040525u7e137221sc4bea5466cde3161@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <8496f91a0806040525u7e137221sc4bea5466cde3161@mail.gmail.com>
Reply-To: matvejchikov@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Solved. The problem was in zero-filled memory node in DTS file. U-boot
doesn't fix it and the kernel gots wrong value. Thanks to Scot Wood.
