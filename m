Message-ID: <3EDDC6D2.5090103@imc-berlin.de>
Date: Wed, 04 Jun 2003 12:15:46 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: jffs2 partition on a TQM860L???
References: <20030604095429.EFD9AC5492@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk schrieb:
> In message <3EDDB269.1080609@imc-berlin.de> you wrote:
>
>>I do use your linuxppc_2_4_devel tree. But still I don't know how to
>>configure one big JFFS2 partition that spawns over two flash banks!
>
>
> Just type "make TQM860L_config ; make oldconfig".
>
>
>>Or maybe I don't understand the difference betwenn the two sturcts:
>>
>>/* partition definition for first flash bank
>>  * also ref. to "drivers\char\flash_config.c"
>>  */
>>static struct mtd_partition tqm8xxl_partitions[] = {
>>...
>>
>>/* partition definition for second flahs bank */
>>static struct mtd_partition tqm8xxl_fs_partitions[] = {
>
>
> You must be confusing source versions. In the linuxppc_2_4_devel tree
> there is just one declaration for tqm8xxl_partitions[].
>
> tqm8xxl_fs_partitions[] was only used in older versions of our tree.
>
> Best regards,
>
> Wolfgang Denk
>

Oh! I see. Apparently while updating to a newer MTD version this file
was overwritten with an older version!

Thanks again!

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
