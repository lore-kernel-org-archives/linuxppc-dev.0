Subject: Re: How to change endian attribute for a memory region
To: "Michael Meriin" <Michael@KSWaves.com>
Cc: linuxppc-embedded@lists.linuxppc.org
From: "Laurent Mohin" <laurent.mohin@acterna.com>
Date: Tue, 15 Oct 2002 11:08:22 +0200
Message-ID: <OF5FAD415F.66B42502-ONC1256C53.003189A8@eni.wago.de>
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Michaêl,

I can't connect the chip as a byte wide device due to performance
degradation.
Due to other constraints, I can't invert MSB and LSB. In fact, due to color
mapping, if I work in 8 bit per pixel, I must address my framebuffer in big
endian mode. In 16 bit per pixel, I need to use little endian mode.
So I really need to change the endian attribute.

Thanks for your answer

Laurent




"Michael Meriin" <Michael@KSWaves.com> on 14/10/2002 10:57:00

To:    linuxppc-embedded@lists.linuxppc.org, Laurent
       Mohin/SE/Wavetek@Global
cc:
Subject:    Re: How to change endian attribute for a memory region



> I'm trying to interface a 405GP chip with an EPSON S1D13506 graphic
> controller. Because the EPSON chip is a little endian, I need to have my
> framebuffer memory acceded in little endian mode.
> What is the best way to change endian attribute for a specific memory
> region (ioremap little endian)?
>
> Laurent

I suggest you to connect it to the uP as a byte wide device, this will
immediately solve your problem.
The second way you can do it for 16 bit bus to connect MSB and LSB wise a
wiser.
>
Best Regards,
                     Michael Meriin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
