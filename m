Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Dan Malek" <dan@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: FCC patch..really
Date: Wed, 28 Aug 2002 07:43:34 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFMEFDDLAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3D6C5FC2.1090204@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > I have another update that does the same thing with the MDIO
> lines per PHY
> > ;)
>
> Please don't.  This stuff doesn't belong in configuration files.  There is
> nothing wrong with creating platform specific configuration in files
> that can be compiled and using a single configuration option and
> #define to
> make this happen.  Cluttered configuration scripts are a source of error
> and headache.

Ok but lets keep the #defines that control the FCC setup and put them into
the platform headers. If the defines are not present then they will default
to the "normal" configuration. Unfortunately with this method you are
required to modify each platform configuration file instead of having it
done as part of the configuration process. I am not sure which would be more
error prone.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
