Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Jean-Denis Boyer" <jdboyer@mediatrix.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Debugging Network Performance
Date: Wed, 5 Jun 2002 06:35:57 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFOECJDIAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <F1BED55F35F4D3118C0F00E0295CFF4DFFA05C@mail.mediatrix.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> With my 200MHz 8260 based board, using kernel 2.4.19-pre7,
> I fetch a large file (~50Mb) with ftp, and send it to /dev/null
>   get large_file /dev/null
> and I obtain the following performance:
>   50216878 bytes received in 5.52 seconds (9090508 bytes/s)

I will check smaller files. I know that there is a nice burst of activity
when the transfer starts. Can you try 100MB+ transfer and see if you still
get the same performance. Perhaps I should try 2.4.19pre7. If I get better
results it sure helps to narrow the search for likely suspects. I will also
try piping to /dev/null.

> If the performance drops in 100Mbps full duplex, the problem might be
> one of configuration between your BCM switch and the external switch.
> Are both ends of the link (between your BCM switch and external switch)
> set to auto-negotiation?

The switch is a LinkSys 5 port 10/100 switch. (no configuration options that
I am aware of) All ports on the BCM should be in auto-negotiate mode. In a
previous version I printed the negotiation status of each port and it showed
100, full-duplex.

Thanks for the pointers. Based on the emails that I have received, I am not
the only one with this problem. Hopefully we can reproduce your results and
provide some feedback to the group.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
