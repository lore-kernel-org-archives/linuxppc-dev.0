Subject: Re: Debugging Network Performance
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
To: acurtis@onz.com
Cc: Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <NCBBIINEHIPFGJPLBEIFOEBEDIAA.acurtis@onz.com>
References: <NCBBIINEHIPFGJPLBEIFOEBEDIAA.acurtis@onz.com>
Content-Type: multipart/mixed; boundary="=-q63d60/DtEkOS6aK5Atf"
Date: 04 Jun 2002 11:50:45 +0200
Message-Id: <1023184245.24574.10.camel@groo>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-q63d60/DtEkOS6aK5Atf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I suggest using netpipe or something so you also can see the impact of
different packet sizes.

I have attached one graph done from a walnut card but I do not remember
exactly what kernel version was used.

On Tue, 2002-06-04 at 06:34, Allen Curtis wrote:
>
> I was wondering if anyone could provide some pointers on monitoring and
> debugging network communications. The performance of Ethernet communications
> seems to vary with kernel revisions. I would like to analyze this problem
> but I need a little guidance on the issue.

--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Borgafjordsgatan 9                Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se


--=-q63d60/DtEkOS6aK5Atf
Content-Disposition: attachment; filename=out.png
Content-Type: image/png; name=out.png
Content-Transfer-Encoding: base64

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

--=-q63d60/DtEkOS6aK5Atf--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
