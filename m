Return-Path: <sassmann@suse.de>
Message-ID: <46C405B3.2040401@suse.de>
Date: Thu, 16 Aug 2007 10:07:15 +0200
From: Stefan Assmann <sassmann@suse.de>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: PS3 improved video mode autodetection for HDMI/DVI
References: <Pine.LNX.4.62.0707121029320.12797@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0707121029320.12797@pademelon.sonytel.be>
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
> If it fails, please add `#define DEBUG' to drivers/ps3/ps3av.c, send me the
> `Monitor Info' output in the kernel log (dmesg), and tell me which of the
> PS3 video modes (1-13) work and which don't. ps3av has a quirk database for
> monitors that advertise non-working modes, so it can probably be fixed.
> (BTW, even if autodetect works fine, I always welcome this information)
>   
Samsung SyncMaster 226BW

The autodetection leaves me with an unsupported resolution. I tried
adding the monitor to the quirk list. Works fine now. Using 720p as
default  resolution might be worth a thought. This should work on all HD
screen.

GOOD: 2,3,5,7,8,10,11,12,13
BAD: 1,4,6,9

Monitor Info: size 96
avport: 00
monitor_id:  4c 2d 7f 02 32 32 45 4d 0d 11
monitor_type: 02
monitor_name: SyncMaster
resolution_60: bits: 0000000d native: 00000000
resolution_50: bits: 00000000 native: 00000000
resolution_other: bits: 00000000 native: 00000000
resolution_vesa: bits: 00000001 native: 00000000
color space    rgb: 01
color space yuv444: 00
color space yuv422: 00
color info   red: X 0293 Y 0155
color info green: X 0125 Y 0269
color info  blue: X 009c Y 0051
color info white: X 0141 Y 0151
color info gamma:  000000dc
supported_AI: 00
speaker_info: 00
num of audio: 00
ps3av_hdmi_get_id: Using supported mode 4


btw, I get the following message while booting:
PS3AV_CID_AV_VIDEO_DISABLE_SIG: failed 2 port 10

does this ring a bell? I'm using kernel 2.6.22 with ps3 patches

Stefan
