Date: Fri, 7 Mar 2003 12:08:02 -0600
From: Nathan Ingersoll <ningerso@ruralcenter.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Runtime Altivec detection
Message-ID: <20030307180802.GB6252@ruralcenter.org>
References: <20030307164753.GA5240@ruralcenter.org> <20030307185458.7bb979cb.damm@opensource.se>
Mime-Version: 1.0
In-Reply-To: <20030307185458.7bb979cb.damm@opensource.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 07, 2003 at 06:54:58PM +0000, Magnus Damm wrote:
> mplayer and ffmpeg does some kind of detection runtime.
> I'm playing with it right now actually.

Last I heard, it was a compile time detection or flag. So you had to build
separate binaries for your G4 and non-G4 machines.

> While at it:
>
> I've seen that -maltivec and -mabi=altivec is passed sometimes.
> If I want to build a binary that should be able to run on a
> G3 without altivec and utilize altivec when present on a G4,
> what flags should I use?

There is no specific flag for doing so, you need some code to detect the
capability, and then decide whether to use the Altivec routine.

--
------------------------------------------------------------------------
| Nathan Ingersoll           \\ Computer Systems & Network Coordinator |
| ningerso@ruralcenter.org    \\ http://www.ruralcenter.org            |
| http://ningerso.atmos.org/   \\ Minnesota Center for Rural Health    |
------------------------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
