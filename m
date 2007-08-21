Return-Path: <sassmann@suse.de>
Message-ID: <46CAD366.4010405@suse.de>
Date: Tue, 21 Aug 2007 13:58:30 +0200
From: Stefan Assmann <sassmann@suse.de>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: PS3 improved video mode autodetection for HDMI/DVI
References: <Pine.LNX.4.62.0707121029320.12797@pademelon.sonytel.be>
	<46C405B3.2040401@suse.de>
	<Pine.LNX.4.62.0708201541230.6197@pademelon.sonytel.be>
	<46C9B172.9030309@suse.de>
	<Pine.LNX.4.62.0708201740080.6197@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0708201740080.6197@pademelon.sonytel.be>
Content-Type: text/plain; charset=UTF-8
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>,
	Ben Collins <ben.collins@ubuntu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven schrieb:
> I know you could get the PS3AV_CID_AV_VIDEO_DISABLE_SIG message in some cases
> when booting immediately into a VESA mode.
>
> I see you have
>
>     CONFIG_CMDLINE="quiet sysrq=1 panic=42 video=ps3fb:mode:0"
>
> Does it go away if you remove the `video=...'?
>   
removing video=ps3fb:mode:0 from CONFIG_CMDLINE has no effect.

Stefan
