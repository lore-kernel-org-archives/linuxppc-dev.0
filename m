Return-Path: <dmitry.torokhov@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 9CA6ADDEF5
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 23:34:09 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so357844uge
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 06:34:07 -0700 (PDT)
Message-ID: <d120d5000710240634j21d2b660t267ace56bd9d6af6@mail.gmail.com>
Date: Wed, 24 Oct 2007 09:34:07 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Johannes Berg" <johannes@sipsolutions.net>
Subject: Re: [PATCH] fix appletouch geyser 1 breakage
In-Reply-To: <1193231110.4510.42.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1193222676.4510.5.camel@johannes.berg>
	<d120d5000710240555m545a4f95v8bfc1ac790273001@mail.gmail.com>
	<1193231110.4510.42.camel@johannes.berg>
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
> Hi,
>
> > My fault, sorry.
>
> No, actually, I was wrong about Geyser 1, mine is a fountain.
>
> > Is there a way to "plug" these Geysers? Waking up the kernel
> > continuously is not nice.
>
> Not sure really, maybe checking for is_geyser instead of is_geyser_3?
>

Well, but what about fountains then? Regardless of the model, if there
is a way to stop "empty" meaurements, we should do it.

-- 
Dmitry
