Message-ID: <3AF81673.B73717AB@mvista.com>
Date: Tue, 08 May 2001 11:53:23 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Ralph Blach <rcblach@raleigh.ibm.com>
Cc: Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: null console
References: <3AF7F4A4.2ADC6059@raleigh.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralph Blach wrote:
>
> Want to create a linux port with a null console.  This is for a box with
> one serial port that will be used
> for a ppp connection.  How is this done?

Don't call the console init function for the serial port.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
