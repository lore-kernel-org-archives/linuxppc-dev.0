Message-ID: <404F51F4.5040000@catapult.com>
Date: Wed, 10 Mar 2004 12:35:48 -0500
From: "Kevin A. Sapp" <Kevin.Sapp@catapult.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RAM Disk problems
References: <20040310150032.D3CBEC0655@atlas.denx.de>
In-Reply-To: <20040310150032.D3CBEC0655@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks to all.
  Wolfgang had it.  No EXT2 support. Duh!

Kevin

>In message <404F26A5.7070807@catapult.com> you wrote:
>
>
>>I am trying to bring up a RAM disk as the root file system.
>>Most everything is working until it come's time to mount it.
>>
>>
>
>This is an ext2 based ramdisk? Do you have ext2  support  enabled  in
>your kernel? If yes, try disabling devfs.
>
>Best regards,
>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
>Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
>I mean, I . . . think to understand you, I just don't know  what  you
>are saying ...                        - Terry Pratchett, _Soul Music_
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
