Message-ID: <3C18CB10.EEFD6586@seranoa.com>
Date: Thu, 13 Dec 2001 10:36:48 -0500
From: Andrew Dixon <andrew.dixon@seranoa.com>
MIME-Version: 1.0
To: ppclist <linuxppc-embedded@lists.linuxppc.org>
Subject: [Fwd: Re: root=/dev/nfs on sbc8260]
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorry, I ment to send this to the list.

-------- Original Message --------
Subject: Re: root=/dev/nfs on sbc8260
Date: Thu, 13 Dec 2001 10:32:45 -0500
From: Andrew Dixon <andrew.dixon@seranoa.com>
Organization: Seranoa Networks
To: Dan Malek <dan@embeddededge.com>
References: <3C17E07F.7144B7BF@seranoa.com>
<3C18445A.80505@embeddededge.com>

Dan Malek wrote:
>
> Andrew Dixon wrote:
>
> > Any insight that people could give would be greatly appreciated.
> It's either the FCC or the server.  Since you have the FCC working in PPCBoot

Yes PPCBoot works like a charm.

<snip>

You could also use your favorite network sniffer to see what traffic,
> if any, went along the network.
>

OK.  I used tcpdump to listen for traffic that this board generates and
I don't see anything once Linux starts up.  Here's what the output looks
like:

rowling:/home/dixon# tcpdump -i eth0 ether src 00a01e901555
<snip>
10:29:53.882149 172.16.1.162.2811 > 172.16.1.202.32828:  udp 4 (DF)
10:29:53.882570 172.16.1.162.2811 > 172.16.1.202.32828:  udp 4 (DF)
10:29:53.882981 172.16.1.162.2811 > 172.16.1.202.32828:  udp 4 (DF)
10:29:53.883393 172.16.1.162.2811 > 172.16.1.202.32828:  udp 4 (DF)
10:29:53.883833 172.16.1.162.2811 > 172.16.1.202.32828:  udp 4 (DF)
10:29:53.884245 172.16.1.162.2811 > 172.16.1.202.32828:  udp 4 (DF)
10:29:53.884688 172.16.1.162.2811 > 172.16.1.202.32828:  udp 4 (DF)
10:29:53.885099 172.16.1.162.2811 > 172.16.1.202.32828:  udp 4 (DF)

Then Linux starts and I get nothing.  Very odd.

Any ideas?

Thanks,
Andy

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
