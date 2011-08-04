Return-Path: <a.heider@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4E39CC54.7030705@infradead.org>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1312228986-32307-6-git-send-email-a.heider@gmail.com>
	<4E39CC54.7030705@infradead.org>
Date: Thu, 4 Aug 2011 18:34:21 +0200
Message-ID: <CAHsu+b_6zYP--kiyiz4P4OBK1QfFrcv+ip1vL5UBgq8SAEMwXw@mail.gmail.com>
Subject: Re: [PATCH 05/15] ps3: Detect the current lpar environment
From: Andre Heider <a.heider@gmail.com>
To: Geoff Levand <geoff@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: cbe-oss-dev@lists.ozlabs.org, Hector Martin <hector@marcansoft.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 4, 2011 at 12:31 AM, Geoff Levand <geoff@infradead.org> wrote:
> On 08/01/2011 01:02 PM, Andre Heider wrote:
>> ---
>> =A0arch/powerpc/include/asm/ps3.h =A0 =A0 =A0 =A0 =A0| =A0 =A07 +++++++
>> =A0arch/powerpc/platforms/ps3/platform.h =A0 | =A0 =A04 ++++
>> =A0arch/powerpc/platforms/ps3/repository.c | =A0 19 +++++++++++++++++++
>> =A0arch/powerpc/platforms/ps3/setup.c =A0 =A0 =A0| =A0 22 ++++++++++++++=
++++++++
>> =A04 files changed, 52 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/ps3.h b/arch/powerpc/include/asm/p=
s3.h
>> index 7f065e1..136354a 100644
>> --- a/arch/powerpc/include/asm/ps3.h
>> +++ b/arch/powerpc/include/asm/ps3.h
>> @@ -39,6 +39,13 @@ union ps3_firmware_version {
>> =A0void ps3_get_firmware_version(union ps3_firmware_version *v);
>> =A0int ps3_compare_firmware_version(u16 major, u16 minor, u16 rev);
>>
>> +enum ps3_ss_laid {
>> + =A0 =A0 PS3_SS_LAID_GAMEOS =3D 0x1070000002000001UL,
>> + =A0 =A0 PS3_SS_LAID_OTHEROS =3D 0x1080000004000001UL,
>
> Only PS3_SS_LAID_OTHEROS is used for anything outside ps3_setup_arch(),
> so I think it makes sense to split this into two patches with one adding
> just PS3_SS_LAID_OTHEROS and ps3_get_ss_laid() with a comment that
> it adds the ps3_get_ss_laid routine.

Sounds reasonable, I will split that into two patches then.
