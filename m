Return-Path: <dmitry.torokhov@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by ozlabs.org (Postfix) with ESMTP id 42780DDEC1
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 00:29:14 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so210230nfd
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 07:29:13 -0700 (PDT)
Message-ID: <d120d5000710240729v2e3faea8u615cfa7f1e489d11@mail.gmail.com>
Date: Wed, 24 Oct 2007 10:29:12 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Johannes Berg" <johannes@sipsolutions.net>
Subject: Re: [PATCH] fix appletouch geyser 1 breakage
In-Reply-To: <1193233015.4510.44.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1193222676.4510.5.camel@johannes.berg>
	<d120d5000710240555m545a4f95v8bfc1ac790273001@mail.gmail.com>
	<1193231110.4510.42.camel@johannes.berg>
	<d120d5000710240634j21d2b660t267ace56bd9d6af6@mail.gmail.com>
	<1193233015.4510.44.camel@johannes.berg>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Anton Ekblad <valderman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/24/07, Johannes Berg <johannes@sipsolutions.net> wrote:
> On Wed, 2007-10-24 at 09:34 -0400, Dmitry Torokhov wrote:
>
> > Well, but what about fountains then? Regardless of the model, if there
> > is a way to stop "empty" meaurements, we should do it.
>
> There is no way on fountains though. We could check the measurement
> ourselves and if no finger is detected decrease the polling frequency or
> something, but there's no hw support.
>

Do yo know who has powerbooks with older geyser models (0x214, 215,
216)? It would be nice to know if they send the data continiously and
whether the geyser 3 reset hack works on them.

-- 
Dmitry
