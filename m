Message-ID: <02bc01c3c003$406fa7c0$3cc8a8c0@ANOSP>
From: "Colin Leroy" <colin@colino.net>
To: "Guido Guenther" <agx@sigxcpu.org>,
	<linuxppc-dev@lists.linuxppc.org>
References: <20031211162011.GD913@bogon.ms20.nix>
Subject: Re: fixup G4 iBook's /proc/cpuinfo
Date: Thu, 11 Dec 2003 17:24:29 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> + { "PowerBook6,3", "iBook G4 12\"",
> + PMAC_TYPE_UNKNOWN_INTREPID, intrepid_features,
> + PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
> + },
>   { "PowerMac7,2", "PowerMac G5",
>   PMAC_TYPE_POWERMAC_G5, g5_features,
>   0,


You can remove the " 12\"" bit, as the 14" are PowerBook6,3 too :)

--
Colin
Ne disez pas disez, mais disez dites

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
