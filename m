Message-ID: <3D6C5FC2.1090204@embeddededge.com>
Date: Wed, 28 Aug 2002 01:29:38 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: acurtis@onz.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: FCC patch..really
References: <NCBBIINEHIPFGJPLBEIFMEEJDLAA.acurtis@onz.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Allen Curtis wrote:

> I have another update that does the same thing with the MDIO lines per PHY
> ;)

Please don't.  This stuff doesn't belong in configuration files.  There is
nothing wrong with creating platform specific configuration in files
that can be compiled and using a single configuration option and #define to
make this happen.  Cluttered configuration scripts are a source of error
and headache.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
