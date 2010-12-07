Return-Path: <risto.suominen@gmail.com>
Received: from mail-ew0-f45.google.com (mail-ew0-f45.google.com
	[209.85.215.45]) by ozlabs.org (Postfix) with ESMTP id 22761B70DA
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Dec 2010 19:51:54 +1100 (EST)
Received: by ewy10 with SMTP id 10so8493289ewy.18
	for <linuxppc-dev@ozlabs.org>; Tue, 07 Dec 2010 00:51:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1291562178.3495.6.camel@jlt3.sipsolutions.net>
References: <AANLkTinaCDvnOCy1e1Ca92hZO5UuB-9HKe4rvLg7TUEx@mail.gmail.com>
	<1291562178.3495.6.camel@jlt3.sipsolutions.net>
Date: Tue, 7 Dec 2010 10:51:52 +0200
Message-ID: <AANLkTin-wbJd6qSMnB0GL=mGL_u-cUY00pEHaWo-hpwK@mail.gmail.com>
Subject: Re: PowerMac G4 (Digital Audio)
From: Risto Suominen <risto.suominen@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/12/5, Johannes Berg <johannes@sipsolutions.net>:
>
>> http://ristosu.wippiespace.com/pub/alsa-tumbler-1.0.22.1-p15.diff
>> http://ristosu.wippiespace.com/pub/alsa-tumbler-1.0.22.1-p16.diff
>
> These patches are odd -- the first one adds something the second
> removes? Am I supposed to look at the combination?
>
Not really, the second one adds gpio16 but still keeps gpio15.
>
> But frankly, it's been so long that it's not all making perfect sense to
> me right now. If you send me a tarball of /proc/device-tree/ maybe I can
> take a look -- just looked at my collection and I don't have that one.
>
> johannes
>
A device tree dump is located at
http://manulix.wikidot.com/hidden:device-tree-my_G4
The tarball can be wget-ted from
http://manulix.wikidot.com/local--files/hidden:device-tree-my-g4/device-tree.tar.bz2

Risto
