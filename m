Return-Path: <michel@tungstengraphics.com>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.182])
	by ozlabs.org (Postfix) with ESMTP id D1734DDDEE
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 03:34:10 +1100 (EST)
Received: by ik-out-1112.google.com with SMTP id c28so87217ika.1
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 09:34:08 -0700 (PDT)
Subject: Re: [PATCH] uninorth agp: don't mark module parameter __devinit
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1225282379.5439.11.camel@johannes.berg>
References: <1225246284.1369.31.camel@johannes.berg>
	<1225282185.3546.376.camel@thor.sulgenrain.local>
	(sfid-20081029_130954_908818_BCA53077)
	<1225282379.5439.11.camel@johannes.berg>
Content-Type: text/plain; charset=utf-8
Date: Wed, 29 Oct 2008 17:34:04 +0100
Message-Id: <1225298044.3546.414.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-10-29 at 13:12 +0100, Johannes Berg wrote:
> On Wed, 2008-10-29 at 13:09 +0100, Michel Dänzer wrote:
> > On Wed, 2008-10-29 at 03:11 +0100, Johannes Berg wrote:
> > > A module parameter can possibly be shown via sysfs, which isn't a good
> > > idea if the section has been removed, so remove the __devinit
> > > annotation.
> > 
> > Under what circumstances could it be shown in sysfs?
> 
> Sorry, my mistake, I overlooked that it had 0 permission:
> module_param(aperture, charp, 0);
> 
> otherwise it would of course be in sysfs.
> 
> Can uninorth_fetch_size be marked __devinit then?

I'm not sure, and none of the other AGP backend drivers seems to do
so...


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer
