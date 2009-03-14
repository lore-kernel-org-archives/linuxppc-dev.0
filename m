Return-Path: <timur.tabi@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.227])
	by ozlabs.org (Postfix) with ESMTP id 0B133DE108
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 11:18:50 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id g9so1030495rvb.1
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 17:18:49 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <e3b3ab5c0903131156l45ab934fyf7fb33b71468594a@mail.gmail.com>
References: <e3b3ab5c0903131156l45ab934fyf7fb33b71468594a@mail.gmail.com>
Date: Fri, 13 Mar 2009 19:18:49 -0500
Message-ID: <ed82fe3e0903131718u2d49cad3j78e2d08d4de0bf4a@mail.gmail.com>
Subject: Re: node /dev/ttyCPM2 not created
From: Timur Tabi <timur@tabi.org>
To: liran raz <liranrazlinux@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 13, 2009 at 1:56 PM, liran raz <liranrazlinux@gmail.com> wrote:

> Does anyone know what I'm missing? or what do I need to configure
> in order to have: /dev/ttyCPM2 ?

My guess is that you don't have udev or mdev running.


-- 
Timur Tabi
Linux kernel developer at Freescale
