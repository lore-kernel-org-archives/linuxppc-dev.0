Subject: Re: R128 Scaling.
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: Stefan Berndtsson <stefan@nocrew.org>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020416133220.782c956e.adrian@humboldt.co.uk>
References: <878z7nuamf.fsf@hades.nocrew.org>
	<20020416133220.782c956e.adrian@humboldt.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Date: 16 Apr 2002 15:12:12 +0200
Message-Id: <1018962733.1590.2316.camel@tibook>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2002-04-16 at 14:32, Adrian Cox wrote:
>
> On 16 Apr 2002 13:49:12 +0200
> Stefan Berndtsson <stefan@nocrew.org> wrote:
>
> > What is the status of the scaling registers for rage128? I saw a patch
> > in the archive, that adds scaling capabilities for the framebuffer,
> > and that seems to work reasonably well.
>
> I started looking at that a while ago, but didn't get very far. To get
> much further (and also to tackle the VGA out problems) I probably need
> the chip docs, but I haven't really pursued them. My one email asking to
> become an X developer was ignored, and I don't know of any other way to
> get the docs currently.

You can apply for them with ATI directly, their developer relations
program to be exact.

> The scaling patches I worked on had a problem with display flickering.

I could resolve that problem with custom modes I obtained in a way Kevin
Hendricks posted here.

> They also needed a general mechanism to get the physical panel size.

Shouldn't be hard with Apple machines, and on x86 one can use the BIOS
as seen in the X driver.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
