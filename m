Subject: Re: aty128fb and EDID
From: Dan Burcaw <dburcaw@terrasoftsolutions.com>
To: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
Cc: Magnus Damm <damm@opensource.se>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200302100816.36075.kevin.hendricks@sympatico.ca>
References: <200302091940.10202.kevin.hendricks@sympatico.ca>
	 <Pine.GSO.4.21.0302101034180.25020-100000@vervain.sonytel.be>
	 <20030210111453.52322aba.damm@opensource.se>
	 <200302100816.36075.kevin.hendricks@sympatico.ca>
Content-Type: text/plain
Message-Id: <1044902485.32265.14.camel@skyfox>
Mime-Version: 1.0
Date: 10 Feb 2003 11:41:25 -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2003-02-10 at 06:16, Kevin B. Hendricks wrote:
> Hi,
>
> I found the code to decode the full block from a variety of source (X11 had
> some of it).  The problem is the "established timings" block was empty in
> my EDID block (or I made a big mistake someplace).

iirc, LCD's don't have "established timings".

> My primary concern was just getting my DFP to work at all at the time.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
