Return-Path: <oakad@yahoo.com>
Received: from web37606.mail.mud.yahoo.com (web37606.mail.mud.yahoo.com
	[209.191.87.89]) by ozlabs.org (Postfix) with SMTP id 2349EB7C7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jan 2010 17:54:29 +1100 (EST)
Message-ID: <341686.17314.qm@web37606.mail.mud.yahoo.com>
Date: Mon, 18 Jan 2010 22:54:28 -0800 (PST)
From: Alex Dubov <oakad@yahoo.com>
Subject: Large physical address support on e500 platform
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm working on an mpc8548 based board and recently I've encountered a=0Apro=
blem, whereupon kernel crashed each time module loading is attempted. I=0At=
raced the problem to the fact, that vmalloc_exec was setting incorrect=0Apa=
ge attributes on allocated pages. This, in turn, happened because I=0Aspeci=
fied "Large physical address support" in the Kconfig, leading to=0ACONFIG_P=
HYS_64BIT and friends being set.=0A=0AIt appears that having this option se=
t on e500 pulls in incorrect headers=0Aand otherwise not working. CPU, howe=
ver, has support for 36b physical=0Aaddressing, which qualifies as "Large p=
hysical address".=0A=0ASo, the obvious question is, what is the current sta=
tus of large physical=0Aaddress support on e500? Is it a problem in current=
 git version or is it=0Anot ready yet?=0A=0AThanks.=0A=0A=0A=0A=0A=0A=0A=0A=
      _____________________________________________________________________=
_____________=0ASee what's on at the movies in your area. Find out now: htt=
p://au.movies.yahoo.com/session-times/
