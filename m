Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id 3FA72DE6DB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Jul 2008 02:49:02 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so64627pyi.27
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jul 2008 09:49:00 -0700 (PDT)
Subject: Re: 4xx USB drivers
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: - Reyneke <reynekejunk@hotmail.com>
In-Reply-To: <BAY101-W55F03E0DA492264568B776BE7D0@phx.gbl>
References: <BAY101-W55F03E0DA492264568B776BE7D0@phx.gbl>
Content-Type: text/plain
Date: Wed, 30 Jul 2008 12:48:56 -0400
Message-Id: <1217436536.13523.3.camel@weaponx>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2008-07-30 at 13:20 +0000, - Reyneke wrote:
> Hi,
> 
> Does anyone know what the state is of the ppc 44x USB host drivers in the powerpc kernel branch (v2.6.25)?
> 
> The EHCI and OHCI all seem to be there and OF aware, but we can't quite get it to work.

On which 4xx board?  I've used OHCI on 440EP with good success.  440EPx
has an Errata for OHCI/EHCI interactions.  AMCC had a patch for arch/ppc
and I believe someone was working on porting that to arch/powerpc
(Vitaly maybe?).  If you only use one driver at a time, it should work
there though.

josh
