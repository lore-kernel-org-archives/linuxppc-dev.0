Date: Mon, 14 Jun 1999 06:32:56 -0400 (EDT)
From: satadru pramanik <satadru@umich.edu>
To: netatalk-admins@umich.edu
cc: linuxppc-dev@lists.linuxppc.org
Subject: problems with linux kernel 2.2.10
Message-ID: <Pine.LNX.4.10.9906140628570.548-100000@beer.pub.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I am running the netatalk-asun 2.1.3 on a linuxppc glibc2.1 system with
kernel 2.2.7, which works beautifully.   However, when I upgrade to kernel
2.2.10 ( the linux vger version)  I get problems with the chooser letting
me login and see my possible mounts, but when I click on a mount
selection, I get a "the connection to this server has been unexpecte3dly
broken."   I have thus downgraded my kernel back to version 2.2.7.

Any ideas on how I can fix this?   here's a dump of the relevant syslog:
Jun 14 06:26:56 beer afpd[525]: ASIP session:548(1) from
141.211.148.101:2048(2)
Jun 14 06:26:56 beer afpd[402]: server_child[1] 525 done
Jun 14 06:27:00 beer afpd[526]: ASIP session:548(1) from
141.211.148.101:2049(2)
Jun 14 06:27:01 beer PAM_pwdb[526]: (netatalk) session opened for user
satadru by (uid=0)
Jun 14 06:27:01 beer afpd[526]: login satadru (uid 500, gid 500)
Jun 14 06:27:01 beer afpd[402]: server_child[1] 526 killed
Jun 14 06:27:11 beer afpd[527]: ASIP session:548(1) from
141.211.148.101:2050(2)
Jun 14 06:27:11 beer afpd[402]: server_child[1] 527 done
Jun 14 06:27:15 beer afpd[528]: ASIP session:548(1) from
141.211.148.101:2051(2)
Jun 14 06:27:15 beer PAM_pwdb[528]: (netatalk) session opened for user
satadru by (uid=0)
Jun 14 06:27:15 beer afpd[528]: login satadru (uid 500, gid 500)
Jun 14 06:27:15 beer afpd[402]: server_child[1] 528 killed



- ----
satadru pramanik `satadru@umich.edu'
"Put your hand on a hot stove for a minute, and it seems like an hour. Sit
with a pretty girl for an hour, and it seems like a minute. THAT'S
relativity." 
- -Albert Einstein
- ---

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 5.0i for non-commercial use
Charset: noconv

iQA/AwUBN2TaZEwK0JxvsXXVEQKZJwCgyLzYBT98bUdoZYkQUGzrtKt4deYAoLbK
rlEH7vTvnuchCUMukPtBhis6
=Yjik
-----END PGP SIGNATURE-----


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
