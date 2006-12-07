Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 34EC267C78
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 02:48:04 +1100 (EST)
Date: Thu, 7 Dec 2006 16:48:02 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] of_platform_make_bus_id(): kill compiler warning
In-Reply-To: <F5EB4110-C3A8-4C7F-98AE-9096A12482B6@kernel.crashing.org>
Message-ID: <Pine.LNX.4.62.0612071647470.27097@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0612071627400.16653@pademelon.sonytel.be>
	<F5EB4110-C3A8-4C7F-98AE-9096A12482B6@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1344672959-1165506482=:27097"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1344672959-1165506482=:27097
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 7 Dec 2006, Kumar Gala wrote:
> On Dec 7, 2006, at 9:29 AM, Geert Uytterhoeven wrote:
> > of_platform_make_bus_id(): Kill a compiler warning which is a real  
> > bug on
> > PPC64: format ‘%d’ expects type ‘int’, but argument 5 has type  
> > ‘long int’
> >
> > Signed-Off-By: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> 
> I think its better to change magic to type int.  atomic_add_return is  
> going to return an int so magic this %ld on ppc32 has to value.

You're right. I'll send a new patch.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
---584337861-1344672959-1165506482=:27097--
