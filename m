Return-Path: <davidkwho@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.194])
	by ozlabs.org (Postfix) with ESMTP id 82356679EA
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Jun 2005 23:31:22 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 37so528251wra
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Jun 2005 06:31:20 -0700 (PDT)
Message-ID: <4dd15d18050613063124ebd58f@mail.gmail.com>
Date: Mon, 13 Jun 2005 09:31:20 -0400
From: David Ho <davidkwho@gmail.com>
To: "colui77@virgilio.it" <colui77@virgilio.it>
In-Reply-To: <4293EE1500034F4D@ims2a.cp.tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4293EE1500034F4D@ims2a.cp.tin.it>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: JVM for PPC405
Reply-To: David Ho <davidkwho@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

At nanometrics, we have tried numerous different JVMs but we ended up
using GCJ instead, it gives us the speed to run applications on a tiny
66MHz MPC8xx so if you are evaluating JVM options, I suggest you try
GCJ included in GCC 4.0.

David

On 6/13/05, colui77@virgilio.it <colui77@virgilio.it> wrote:
> Hi all,
> I need to installa a JVM on montavista linux for ML300 (PPC405).
> I tried the Blackdown 1.3.1 for PPC but it doesn't seems to work
> (at the command
> $ java
> I received
> illegal istruction)
> Any suggestion? Please I need help...
> Luigi
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
