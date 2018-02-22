Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zn0270CPVzF19B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 14:19:11 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alastair D'Silva <alastair@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, frederic.barrat@fr.ibm.com,
 Greg KH <gregkh@linuxfoundation.org>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [PATCH] ocxl: Add get_metadata IOCTL to share OCXL information to
 userspace
In-Reply-To: <1519255934.2867.3.camel@au1.ibm.com>
References: <20180221045736.7614-1-alastair@au1.ibm.com>
 <CAKTCnz=cy5CkeRjJYpZ1NQpyQN-BVTvKXUxTxOMtTNosZFqJ7A@mail.gmail.com>
 <1519255934.2867.3.camel@au1.ibm.com>
Date: Thu, 22 Feb 2018 14:19:10 +1100
Message-ID: <87h8q9r9sh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Alastair D'Silva" <alastair@au1.ibm.com> writes:

> On Wed, 2018-02-21 at 17:43 +1100, Balbir Singh wrote:
>> On Wed, Feb 21, 2018 at 3:57 PM, Alastair D'Silva <alastair@au1.ibm.c
>> om> wrote:
>> > From: Alastair D'Silva <alastair@d-silva.org>
>> > 
...
>> > diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
>> > index 4b0b0b756f3e..16e1f48ce280 100644
>> > --- a/include/uapi/misc/ocxl.h
>> > +++ b/include/uapi/misc/ocxl.h
>> > @@ -32,6 +32,27 @@ struct ocxl_ioctl_attach {
>> >         __u64 reserved3;
>> >  };
>> > 
>> > +/*
>> > + * Version contains the version of the struct.
>> > + * Versions will always be backwards compatible, that is, new
>> > versions will not
>> > + * alter existing fields
>> > + */
>> > +struct ocxl_ioctl_get_metadata {
>> 
>> This sounds more like a function name, do we need it to be
>> _get_metdata?
>> 
>
> It pretty much is a function, it returns to userspace metadata about
> the descriptor being operated on.

It's not a function, it's a struct?

Outside of "management English" "get" is a verb, so using it in the name
of the struct is confusing, it should be a noun phrase.

cheers
