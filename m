Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5C157DDDEE
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 19:46:08 +1100 (EST)
Message-ID: <4bd87c33b7df6b3726a9526f15b87aa2.squirrel@secure.sipsolutions.net>
In-Reply-To: <1225298044.3546.414.camel@thor.sulgenrain.local> 
References: <1225246284.1369.31.camel@johannes.berg>
	<1225282185.3546.376.camel@thor.sulgenrain.local>
	<1225282379.5439.11.camel@johannes.berg>
	<1225298044.3546.414.camel@thor.sulgenrain.local>
Date: Thu, 30 Oct 2008 09:45:59 +0100 (CET)
Subject: Re: [PATCH] uninorth agp: don't mark module parameter __devinit
From: "Johannes Berg" <johannes@sipsolutions.net>
To: Michel =?iso-8859-15?Q?D=E4nzer?= <michel@tungstengraphics.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-15
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michel Dänzer wrote:

>> Can uninorth_fetch_size be marked __devinit then?
>
> I'm not sure, and none of the other AGP backend drivers seems to do
> so...

Well, either it can, or marking "aperture" is wrong, no?

johannes
