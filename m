Return-Path: <ericvh@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AE27EB6FA9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Jun 2011 12:10:36 +1000 (EST)
Received: by fxm5 with SMTP id 5so31666fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 07 Jun 2011 19:10:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1307494181.2874.214.camel@pasglop>
References: <1307472447-1656-1-git-send-email-ericvh@gmail.com>
	<1307494181.2874.214.camel@pasglop>
Date: Tue, 7 Jun 2011 21:10:31 -0500
Message-ID: <BANLkTik596Oo4MTmKO62pmF2yXhYv8Nsvg@mail.gmail.com>
Subject: Re: [PATCH] [RFC][V3] bluegene: add entry to cpu table
From: Eric Van Hensbergen <ericvh@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	bg-linux@lists.anl-external.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> +#define PPC_FEATURE_HAS_FPU_FP2 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00000040
>
> Any chance for a better name ?
>

That's the official external name,  it sucks.  I'm happy to
PPC_FEATURE_DOUBLE_HUMMER if you'd prefer, otherwise I'm not feeling
too creative, but am open to artistic suggestions.

       -eric
