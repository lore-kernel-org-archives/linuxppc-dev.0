Subject: Re: adding a new driver
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: rahul dev <rahul_dev_agg@hotmail.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <Sea1-F455BpsUNbGX4H00068403@hotmail.com>
References: <Sea1-F455BpsUNbGX4H00068403@hotmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: 16 Jun 2003 15:59:00 +0200
Message-Id: <1055771940.4931.14.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2003-06-16 at 15:21, rahul dev wrote:
   My doubt is that  what will happen if that page(which contains my buffer)
>   has been swapped  out ?? Can i prevent that page from being swapped out.
>   Or is there some other mechanism for that.

Kernel memory is locked so it can't be swapped out.

--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 719 70 20
Tellusborgsvägen  90              Fax: +46 8 719 29 45
126 25 Stockholm                  ken@switchboard.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
