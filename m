Message-ID: <3D6C4904.1060101@embeddededge.com>
Date: Tue, 27 Aug 2002 23:52:36 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: acurtis@onz.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: FCC patch..really
References: <200208271708.04797.acurtis@onz.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Allen Curtis wrote:


> +    if [ "$CONFIG_FCC1_ENET" = "y" ]; then
> +      choice 'RX Clk Source'	\

Please don't do this.......it doesn't belong in the configuration
file.  There are more things unique to a board configuration than
the clock routing.  This belongs as a structure in a C file, selectable
by board type (along with other board specific selections).

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
