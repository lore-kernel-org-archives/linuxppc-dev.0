From: Francois.CAU@st.com
Date: Tue, 23 Nov 1999 13:45:34 +0100
Message-Id: <H0000a4207bc43dd@MHS>
In-Reply-To: <383A6B90.7734B3D5@ssl.co.uk>
Subject: Re: tv tuner/video
MIME-Version: 1.0
To: sacha@ssl.co.uk
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


     
> 1. What is the state of tv card support on LinuxPPC? I've searched the 
> linuxppc-dev logs and seen some announcements of bt848 support. 

The bttv driver (driver for bt848 based cards) is working on LinuxPPC.
     
> 2. The bt848 cards I've seen seems to offer v. limited real-time continuous 
> capture (320 x240 == 1/4 NTSC); I don't know if this is a limitation of the 
> chipset or the cards. I'm looking for full streaming PAL capture to memory. 
> Is this beyond the bandwidth of PCI? If so, is it usual for cards that 
> offer this to do hardware compression first?

The PCI bandwidth is large enough for video. TV applications like xawtv 
have 2 modes: 
- Overlay, where the TV card is PCI-bus-master and directly writes in the 
video memory. 
- Grabbing, where the application grabs each picture, and then displays it 
on the screen. You can even process the pictures before displaying them.

The bottle-neck for continuous capture of un-compressed, full-size video 
comes from the hard-disk.

Francois


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
