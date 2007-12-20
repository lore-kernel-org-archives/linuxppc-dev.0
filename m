Return-Path: <clemens.koller@anagramm.de>
Message-ID: <476A47CA.50004@anagramm.de>
Date: Thu, 20 Dec 2007 11:45:30 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: pjmaiya <pjmaiya@signal-networks.com>
Subject: Re: tiny login
References: <001401c842c0$69c0dba0$4601a8c0@signet>
In-Reply-To: <001401c842c0$69c0dba0$4601a8c0@signet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

pjmaiya schrieb:
> hi,

- don't cross-post
- don't post HTML to the lists

> I am using tiny login provided by montavista. Binaries already obtained 
> from tool provided from montavista. We are able to add only 10 users. 
> But I need to add more than 10 users.

Tried to contact montavista for support? ;-)

> I have already downloaded free open source for tinylogin 
> (tinylogin-1.4). Can we modifiy this source code of this version and 
> support users more than 10??
> If yes, can somebody inform step to build tiny login and installation 
> method.

Well, you propably want to understand the advantage of open source
software first. You can (depending on the license) change the code
according to your needs...

Read: http://tldp.org/HOWTO/Software-Building-HOWTO.html

If you have questions, please tell exactly, where you have a problem.

$ wget http://tinylogin.busybox.net/downloads/tinylogin-1.4.tar.bz2
$ tar xvf tinylogin-1.4.tar.bz2
$ cd tinylogin-1.4
$ make

works like a charm.

A quick look into login.c says:
// login defines
#define TIMEOUT       60
#define FAIL_DELAY    3
#define EMPTY_USERNAME_COUNT    10
                                ^^^^
... which looks quite promising!
Ask the busybox guys for details since this is off-topic here.

Regards,

Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
