Message-ID: <40CA3FDE.80706@mvista.com>
Date: Fri, 11 Jun 2004 16:27:26 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Mark Chambers <markc@mail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: U-Boot and kernel 2.6
References: <20040611144323.F293AC109F@atlas.denx.de> <40CA25B8.8050809@mvista.com> <015901c4500a$735d0eb0$0301a8c0@chuck2>
In-Reply-To: <015901c4500a$735d0eb0$0301a8c0@chuck2>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark Chambers wrote:

>I have seen many references to OCP.  How does one find out what it is?
>
AFAIK, the best way is to just look at the code: arch/ppc/syslib/ocp.c.
Its pretty straightforward.  Its used extensively by the 4xx code:
arch/ppc/platforms/4xx/*.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
