Return-Path: <diggskevin38@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1542CB6EEA
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 May 2011 05:24:17 +1000 (EST)
Received: by vws20 with SMTP id 20so658448vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 17 May 2011 12:24:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1305589123.2781.15.camel@pasglop>
References: <BLU156-w53FEA9E58A7EB19B0F239E838A0@phx.gbl>
	<9136.1305527852@neuling.org> <1305589123.2781.15.camel@pasglop>
Date: Tue, 17 May 2011 14:24:13 -0500
Message-ID: <BANLkTinuzAwxxMJ+BAYrrotH6an=wvZ3=Q@mail.gmail.com>
Subject: Re: book to learn ppc assembly and architecture
From: kevin diggs <diggskevin38@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
	s shaiju <sha_neb@hotmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Mon, May 16, 2011 at 6:38 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Mon, 2011-05-16 at 16:37 +1000, Michael Neuling wrote:
>> > what =A0is =A0the =A0best =A0book =A0to =A0learn =A0assembly =A0and =
=A0architecture .
>>

Assuming you have a powerpc compiler available you can use the -S
option to produce assembly listings.
