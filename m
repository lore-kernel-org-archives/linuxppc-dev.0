Subject: Re: Efficient handling of RTP frames?
From: Matevz Langus <matevy@arhitektova-delavnica.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20040510205808.GA4313@mars.ravnborg.org>
References: <20040510205808.GA4313@mars.ravnborg.org>
Content-Type: text/plain
Message-Id: <1084264082.4338.2.camel@n1020>
Mime-Version: 1.0
Date: Tue, 11 May 2004 10:28:02 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I did the following in advance to all others said before:
left UDP CRC field empty, so you don't need to calculated CRC. VoIP
systems do not complain about that.

rgds,
  Matevz

On Mon, 2004-05-10 at 22:58, Sam Ravnborg wrote:
> Hi all.
>
> We (my company) are looking into a solution for transporting a high amount
> of RTP packets across a single CPU. A 82xx, presumeably a 8270.
> With high amount of RTP packets we are talking about 10 to 20.000 packets
> per second with a payload size of ~64 bytes each (on top of UDP header).
>
> The RTP packets needs to be sent between an external device connected
> to one of the FCC's (needs to write our own driver here) and the Ethernet
> port sitting on FCC1.
>
> Does this sound like a dead-end doing this in Linux?
>
> Can anyone point in a direction where to find more information
> about how to realise this in the most efficiet way?
>
> Google did not bring up anything useful.
>
> Thanks in advance,
>
> 	Sam
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
