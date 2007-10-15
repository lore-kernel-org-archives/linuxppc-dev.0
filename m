Return-Path: <pradyumna.sampath@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id 689E1DE303
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 00:05:49 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so3726380pyi
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 07:05:48 -0700 (PDT)
Message-ID: <f87351060710150705l5e4d1ba5v6806686cd25418bb@mail.gmail.com>
Date: Mon, 15 Oct 2007 19:35:47 +0530
From: "Pradyumna Sampath" <pradyumna.sampath@gmail.com>
To: "S. Fricke" <silvio.fricke@gmail.com>
Subject: Re: can and mpc5200b
In-Reply-To: <20071015133233.GB4859@sfrouter>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071015133233.GB4859@sfrouter>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Silvio,

On 10/15/07, S. Fricke <silvio.fricke@googlemail.com> wrote:
> Hello Friends,
> what is the reasonable can-driver for a mpc5200b?
>
> I have seen for the peak-3.17 driver a port for the mpc5200 from denx on their
> website, but with kernel 2.6.23 I dont have a chance to use this?

Check this out http://developer.berlios.de/projects/socketcan/ . This
is the CAN driver we use and it works pretty well for us. It is very
updated and supports the mscan chipset that is available with the
mpc5200b.

HTH
regards
/prady
-- 
htp://prady.livejournal.com
