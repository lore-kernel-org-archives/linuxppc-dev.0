In-Reply-To: <20040727223033.79CE4C109F@atlas.denx.de>
Subject: Re: more questions about 8xx microcode patches
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <OFA36575DA.B7252443-ON85256EDF.003DB9EE-85256EDF.003E5D30@nanometrics.ca>
From: David Ho <DavidHo@nanometrics.ca>
Date: Wed, 28 Jul 2004 07:21:10 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


owner-linuxppc-embedded@lists.linuxppc.org wrote on 07/27/2004 06:30:28 PM:

>
> Just to add to the complexity: are you aware that the  parameter  RAM
> relocation  may  be  different between 8xx processors? For example it
> seems that on the 866 family  you  can  relocate  PRAM  even  without
> loading any uCode by just writing the correct offset to (for example)
> the spi_rpbase register.
>

I just had a conversation with Wolfgang on the 866 uCode patch situation.
It appears that the I2C/SPI patch is already incorporated in this silicon
rev.  Please look at the follow post for detail of my findings.

http://sourceforge.net/mailarchive/message.php?msg_id=9072298

Hope this help you along the way.  Or it might not.

Regards,

David Ho
Nanometrics Inc.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
