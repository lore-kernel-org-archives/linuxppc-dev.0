MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3252A.2CBB3D50"
Subject: PATCH: arch/ppc/8xx_io/fec.c (2)
Date: Wed, 28 May 2003 11:02:36 -0400
Message-ID: <AB5AF73EAF23304EA1B932174137CED702FB71@m5tmail.m5t.com>
From: "Jean-Denis Boyer" <jdboyer@m5t.com>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

------_=_NextPart_001_01C3252A.2CBB3D50
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Tom,

Here is the same patch, with respect to the Linux coding standards, and =
comments from Dan.

Regards,
--------------------------------------------
 Jean-Denis Boyer, Software Designer
 M5T Centre d'Excellence en T=E9l=E9com Inc.
 4283 Garlock Street
 Sherbrooke (Qu=E9bec)
 J1L 2C8  CANADA
 (819)829-3972 x241
--------------------------------------------

------_=_NextPart_001_01C3252A.2CBB3D50
Content-Type: application/x-gzip;
	name="patch_8xx_fec_20030528.diff.gz"
Content-Transfer-Encoding: base64
Content-Description: patch_8xx_fec_20030528.diff.gz
Content-Disposition: attachment;
	filename="patch_8xx_fec_20030528.diff.gz"

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
SH83N40nfVP8B4y32yrpDQAA

------_=_NextPart_001_01C3252A.2CBB3D50
Content-Type: application/x-gzip;
	name="patch_8xx_fec_20030528.diff.gz"
Content-Transfer-Encoding: base64
Content-Description: patch_8xx_fec_20030528.diff.gz
Content-Disposition: attachment;
	filename="patch_8xx_fec_20030528.diff.gz"

H4sIAMXO1D4CA61WbW/aSBD+bH7FtJUqCDEvpiQkNFGqhN4hJbTKi3ofTrIcs4ZVjO2z1ySozf32
e2bXgCG0ut6VD8Ys8/rMMzNr2zY5jXcNp22nfqcRp3LS9FJ/2kwSv9l7enJl3AyE3/CtqziiK29B
zgG1u8cd57jbJafV6lTq9XrJxHe0v4ix0e5Ru3XcPTpuO0b77Ixs58DZP6A6fx3S2VmFZlK6ocyU
q6w9fg9SIfovj6fCG+84Vp4M+5W6jJRl8e9MxUkiWLJCaoE3EVCm0txXNBvL2E1hxh17yqOvFbLy
9gGlYjL3YIODO2wdcnCHrd4+YuboLJHQCb2tVqtyNvMSV9FebXj14bP74eLiumafypnrJ7OGn7jI
vQa3OgrYhJZI7FOcunzCLjmoutXco+EkilNBaioz8qLsUaQkA/wUCOavXGSK8MwFTb2M7oWIqMiq
AXXao9uS4KMMQ8jgty2zLAfyj1MosC1jAy5SCHqpWuo38YS7agmuGo6sVKg8jQAmkuD/IcC5L8Gv
0ckJje4uL2saOitJAfpD9fXVcIgkxhTFxGKv/oxeaxxW9jSw3Q7KXT88aO33DK6mXFw+7SPRKs8k
wkwY+9bScRFDWdTG39V/W5TaZhVgY1lyJK0zfbUNxS+xzvngUc4JkOAvyLQLWA7eab4dOvudlsHF
oFY1kgzkM7MGpPmYR76ScZSRijUhmrqqutQqBY1mIAD+pzhYsgOi0zTOJ1MtdHUx/AQGGAItyAMD
UUERjUEamASJ8gyv9yJgcnJJvUCBmh59HJwziYTS6uAPPCvp0zyWYx2KTl/zrVo0WySUOxZz6Qva
wzdQ/Qpg8yiTkwhOwjiaUBB6k4yrkHlz4epfVf2s8aEfyqp+KRXHIFe3mNEIclvnGdzdig0I/c/g
5nEIg6EgLjO48JMD4eeya/V1c1ZXTcds3J4jpaa0T4txU/D5B8BQGRhtKnb92fg7mOyTD6opSqYL
luI0/VpFsxikoQfD33b3XXv/iOrt7mEHRGYCv5EBZq51/mn0cfibe3czcJl3UDN+rC0/yAVPV/LE
LkQ00ILlMGLmnoJgoEGHoH3KZzwAVmVZlUG/QGxXYTY0ikLiy5RSy7+snL1mBKcs/Eil3LusZwpi
jvSuWX6ae+t3dNoH/yGKH0Mxngjdg9xwaZonigd+EqNh70PRoGFAjzzu5wJjVBXQYmS2NbY9pxia
JcPe2jAI63Gf3i/WyMWJiKq1BjDlfjXzPGAeoZ48vzFAESmeMPUFTgXPAMTHnS4iD0HpmeD5vsgy
Mz2GQyPf5C+9HwpE3rKWOzgf3V5fuoPb3wfX7mCkt0WrcGVtQ0bfTnYp6cH+XLF5VJYYqum4jN4+
ReoucDRLZltsyddUhDJ6qPW5IssFqGfaWGZJiMsJd0Oe6XR+RUInBT/6VuGPZ2gcYgQJpWQ0yQrg
9EZAl/BOwKtZolR9DY/HlEfiKRE+NjVdIvo1W8xO1dcnp23uT06ntd9ua1rAzosGwc4wnUjbnahv
IDeYOKulgFafzfJI+h7vF4KBOOXqm5FvLgxbU56nJubKG2wPGegbA4x+maI0WBeFHhMrm8Y5QHj0
JNqareLKw6zUpNwBYgn4z8PR1d0f9K18dj24GdwWQHScIw1Ep+ssgfivZtf8K2unmFOZ62Hpoi1R
+6dWu6U/fEX6IbrXwl4SbkEJY4SF8hLpFbSbS2oTW73/y7O7yB43Kcfh9Hu94iJtbbCJlJyJOFeE
ik5SzxdBHi7vCUov7eVFjR3YHPZ5KLyUoANvRcy423HI3DgrMqKAtqXZvMZKirnAjCyQHg1uXaj2
dWvB8EBPlA1rgYxkNhUlszuMzoXP85xtDke3g+vru8+3TadG79+Tc9Q3WF/ITBuHUIMuBecbLrSr
UsC0RQw587KHXdF+Z3vpLG5gnO1mieCr9Itw9Sbn//SOMNPKHMC0qaZGedP2cgJtpmKs7+Dy2xP6
u7prPOmb4j89Y3j34g0AAA==

------_=_NextPart_001_01C3252A.2CBB3D50--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
