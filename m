Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Dan Malek" <dan@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: FCC patch..really
Date: Tue, 27 Aug 2002 21:11:25 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFMEEJDLAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3D6C4904.1060101@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > +    if [ "$CONFIG_FCC1_ENET" = "y" ]; then
> > +      choice 'RX Clk Source'	\
>
> Please don't do this.......it doesn't belong in the configuration
> file.  There are more things unique to a board configuration than
> the clock routing.  This belongs as a structure in a C file, selectable
> by board type (along with other board specific selections).

This may not be the right implementation but I believe it is the right
direction. Personally I am tired of looking at all the different board
specific implementations and conditional compile statements. How can we
accomplish the same thing without cluttering the code with platform stuff? I
think there needs to be an effort to define the kernel features and have the
configuration translate platform features into generic kernel features that
can be used by everyone. It doesn't do anyone any good to make them splunk
though the Linux source to find platform tweaks. (although it does help to
keep us contractors employed)

I have another update that does the same thing with the MDIO lines per PHY
;)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
