Subject: Re: How do you change the program counter (PC)
From: Kenneth Johansson <ken@kieraypc01.tn.sw.ericsson.se>
To: Shen Rong <rshen@udtech.com.cn>
Cc: Jason Park <jason@amadeus.kist.re.kr>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <025b01c2c355$199c8600$e600a8c0@udtech.net>
References: <001701c2c33f$298715f0$5e207aa1@fish>
	<025b01c2c355$199c8600$e600a8c0@udtech.net>
Content-Type: text/plain; charset=ISO-8859-1
Date: 24 Jan 2003 14:20:26 +0100
Message-Id: <1043414426.4533.24.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2003-01-24 at 04:02, Shen Rong wrote:
>
> SREC: (I am not much sure) It seems an old format used mostly by motorola.
> It's like BIN format, but has other information used for downloading. It seems
> some bootloaders need SREC format for downloading.
>

SREC is more or less the same as a BIN file but it has an address and
checksum so it would be much smaller if you want to put a byte at 0 and
one at 100000 and you can be sure that is is correctly transfered.

--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Tellusborgsvägen  94              Fax: +46 8 404 72 72
126 25 Stockholm                  ken@switchboard.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
