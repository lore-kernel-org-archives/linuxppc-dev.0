Subject: RE: RTC drift on Walnut?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 10 Jul 2001 13:29:24 -0400
Message-ID: <FF6CF34C346E724596A2FB5CAAB2C49750C32B@voyager.ops.infiniswitch.com>
From: "Wright, David" <dwright@infiniswitch.com>
To: "Torben Mathiasen" <torben@kernel.dk>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


OK -- I'm running the 010303 version of Linux 2.4.2 from MontaVista
and I am *not* seeing significant clock drift on a Walnut.

  -- David Wright


> -----Original Message-----
> From: Torben Mathiasen [mailto:torben@kernel.dk]
> Sent: Tuesday, July 10, 2001 1:26 PM
> To: Armin Kuster
> Cc: Torben Mathiasen; linuxppc-embedded@lists.linuxppc.org
> Subject: Re: RTC drift on Walnut?
>
>
>
> On Tue, Jul 10 2001, Armin Kuster wrote:
> > I am running on what will be the next version of 405 kernel from
> > MontaVista.  It is using the new todc_time routines.  I saw
> about a 30
> > second drift.
> >
>
> Thanks for the update. I assume you guys are continously
> merging your code with
> the official PPC tree, so this bug must also be present there.
>
> I think its weird this issue haven't come up on the list
> before. There seem to
> be a lot of people running on the walnut system. It would be
> interesting to
> hear from people _not_ having this drift.
>
> Regards,
> Torben Mathiasen
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
