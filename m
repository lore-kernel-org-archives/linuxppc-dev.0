Message-ID: <40E4E804.5010606@iti.fi>
Date: Fri, 02 Jul 2004 07:43:48 +0300
From: Kate Alhola <kate@iti.fi>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: Stefan Nickl <Stefan.Nickl@kontron.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Lite5200 PCI not working
References: <20040701222938.2B62CC109F@atlas.denx.de>
In-Reply-To: <20040701222938.2B62CC109F@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

>That's  why  we  implemented  drivers  fopr  the  Coral-P  which  are
>independedt of the byte-order (and available under GPL).
>
>
>
Do you meaean that responsibility of byte order is left to application
level ?
Linux fbdev just maps display memory to user application space and so it
cant do anything for how R,G,B bits are ordered within word. It is
then responsibility to GUI-engine ( X-server, Embedded-QT ) to
handle this ordering.

Kate


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
