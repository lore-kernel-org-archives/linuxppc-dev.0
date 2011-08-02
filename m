Return-Path: <dm@m-200.ru>
From: <dm@m-200.ru>
To: "'Duait'" <hvlp@hvlp.ru>
Subject: RE: [Cbe-oss-dev] [PATCH 09/15] ps3: Limit theb number of regions
	per	storage device
Date: Tue, 2 Aug 2011 23:55:04 +0400
Message-ID: <002801cc514e$13943240$3abc96c0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Cc: 'Geoff Levand' <geoff@infradead.org>, cbe-oss-dev@lists.ozlabs.org,
	'Hector Martin' <hector@marcansoft.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Sent from my HTC Touch HD

-----Original Message-----
From: linuxppc-dev-bounces+dm=3Dmdtech.ru@lists.ozlabs.org =
<linuxppc-dev-bounces+dm=3Dmdtech.ru@lists.ozlabs.org>
Sent: 01 =D0=B0=D0=B2=D0=B3=D1=83=D1=81=D1=82=D0=B0 2011 23:58
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geoff Levand <geoff@infradead.org>; cbe-oss-dev@lists.ozlabs.org =
<cbe-oss-dev@lists.ozlabs.org>; Hector Martin <hector@marcansoft.com>; =
linuxppc-dev@lists.ozlabs.org <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [Cbe-oss-dev] [PATCH 09/15] ps3: Limit the number of =
regions per	storage device

On Mon, Aug 1, 2011 at 10:30 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Aug 1, 2011 at 22:03, Andre Heider <a.heider@gmail.com> wrote:
>> There can be only 8 regions, add a sanity check
>
> Why can there be only 8 regions?

I believe lv1 limits it to 8? I might be mistaken here, it mostly is a
check for the patches after this one
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-d
