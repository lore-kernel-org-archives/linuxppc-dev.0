Return-Path: <michel@tungstengraphics.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.191])
	by ozlabs.org (Postfix) with ESMTP id 49D8EDDDF6
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 19:50:10 +1100 (EST)
Received: by fk-out-0910.google.com with SMTP id e30so263076fke.9
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 01:50:07 -0700 (PDT)
Subject: Re: [PATCH] uninorth agp: don't mark module parameter __devinit
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <4bd87c33b7df6b3726a9526f15b87aa2.squirrel@secure.sipsolutions.net>
References: <1225246284.1369.31.camel@johannes.berg>
	<1225282185.3546.376.camel@thor.sulgenrain.local>
	<1225282379.5439.11.camel@johannes.berg>
	<1225298044.3546.414.camel@thor.sulgenrain.local>
	<4bd87c33b7df6b3726a9526f15b87aa2.squirrel@secure.sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Date: Thu, 30 Oct 2008 09:50:03 +0100
Message-Id: <1225356603.3546.473.camel@thor.sulgenrain.local>
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

On Thu, 2008-10-30 at 09:45 +0100, Johannes Berg wrote:
> Michel Dänzer wrote:
> 
> >> Can uninorth_fetch_size be marked __devinit then?
> >
> > I'm not sure, and none of the other AGP backend drivers seems to do
> > so...
> 
> Well, either it can, or marking "aperture" is wrong, no?

Makes sense, but I'm not sure about all the conditions and implications
involved.


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer
