Date: Mon, 22 Feb 1999 11:26:22 -0700 (MST)
From: Cort Dougan <cort@persephone.cs.nmt.edu>
To: Matt Porter <mmporter@home.com>
cc: Paul.Mackerras@cs.anu.edu.au,
        Hartmut Koptein <koptein@et-inf.fho-emden.de>,
        zankel@tarantel.rz.fh-muenchen.de, bh40@calva.net,
        davidsen@prodigy.com, marsmail@globegate.utm.edu, dvdoug@tiac.net,
        paubert@iram.es, jskov@cygnus.co.uk, hozer@drgw.net,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [ppc-dev] Summary: Restructuring Efforts
In-Reply-To: <Pine.LNX.3.96.990222093231.1072A-100000@liberty.chnd1.az.home.com>
Message-ID: <Pine.LNX.3.96.990222112522.4988B-100000@persephone.cs.nmt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thus the name arch/ppc/mbxboot rather than emb_boot or some such thing.
They're all not mbx, but that makes it more clear that it's for mbx-type
boards (rather than prep/mtx).

}I was concerned that people might think that ALL embedded boards would
}fall into the "embedded" bootloader and it could cause confusion down the


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
