Return-Path: <cbe-oss-dev@ml.breakpoint.cc>
Date: Thu, 12 Jul 2007 14:10:37 +0200
From: Sebastian Siewior <cbe-oss-dev@ml.breakpoint.cc>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [Cbe-oss-dev] PS3 improved video mode autodetection for HDMI/DVI
Message-ID: <20070712121037.GD24117@Chamillionaire.breakpoint.cc>
References: <Pine.LNX.4.62.0707121029320.12797@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <Pine.LNX.4.62.0707121029320.12797@pademelon.sonytel.be>
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

* Geert Uytterhoeven | 2007-07-12 10:40:47 [+0200]:

>If you're using a PS3 with a HDMI or DVI-D(+HDCP) monitor, please give it a
>try.
Got 1920x1200 @60Hz on my Eizo FlexScan S2411W on boot. No quirk
required for that one :)

>(BTW, even if autodetect works fine, I always welcome this information)
Here it is:

Monitor Info: size 96
avport: 00
monitor_id:  15 c3 50 18 01 01 01 01 04 11
monitor_type: 02
monitor_name: S2411W
resolution_60: bits: 0000400d native: 00000000
resolution_50: bits: 00000000 native: 00000000
resolution_other: bits: 00000000 native: 00000000
resolution_vesa: bits: 00000009 native: 00000000
color space    rgb: 01
color space yuv444: 00
color space yuv422: 00
color info   red: X 028f Y 0152
color info green: X 0133 Y 026f
color info  blue: X 009a Y 003d
color info white: X 0141 Y 0151
color info gamma:  000000dc
supported_AI: 00
speaker_info: 00
num of audio: 00
ps3av_hdmi_get_vid: Using supported resolution 15
ps3_av vuart_01:  <- ps3av_probe:1014

>Geert Uytterhoeven

Sebastian
