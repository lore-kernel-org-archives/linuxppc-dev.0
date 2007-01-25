Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id E619BDDF93
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 00:33:12 +1100 (EST)
Date: Thu, 25 Jan 2007 14:33:11 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 8/14] ps3: bind interrupt to cpu
In-Reply-To: <45B8188A.5070900@am.sony.com>
Message-ID: <Pine.LNX.4.62.0701251432390.31896@pademelon.sonytel.be>
References: <45B8188A.5070900@am.sony.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 24 Jan 2007, Geoff Levand wrote:
> +enum ps3_cpu_binding {
> +	PS3_BINDING_CPU_0 = 0,
> +	PS3_BINDING_CPU_1 = 1,
> +	PS3_BINDING_CPU_ANY = 3,
> +};

I find the 3 a bit strange. Perhaps it's better to use -1 instead?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
