Date: Wed, 24 Oct 2001 11:54:42 -0400
Subject: Re: JDK 1.3
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v472)
Cc: linuxppc-dev@lists.linuxppc.org
To: Stefan Pfetzing <dreamind@dreamind.de>
From: Kevin Hendricks <khendricks@ivey.uwo.ca>
In-Reply-To: <20011024041846.A31846@server>
Message-Id: <706EA32A-C897-11D5-A979-0030654D6A26@ivey.uwo.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

What symbol does it complain about?

Mozilla has changed it plugin interface slightly in 0.93, 0.94, and 0.95
which is making for a real pain.  I asked the x86 Blackdown guys and
they are build jdk 1.3.1 against mozilla 0.91 and that plugin seems to
work with everything to date.  The issues come in when later mozilla
headers are used to build the plugin.

I will retry building the plugin against mozilla 0.91 and post it in the
form of the jre for people to try.

Kevin


On Tuesday, October 23, 2001, at 10:18 PM, Stefan Pfetzing wrote:

>
> Hi,
>
> somebody got the Blackdown j2sdk 1.3.0-PL1 Plugin for Mozilla to work
> with
> Mozilla 0.9.5 ? For me it complains about a missing symbol and won't
> start
> mozilla, when linking the javaplugin into the mozilla dir.
>
>
> bye
>
> dreamind
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
