from flask_login import UserMixin
from typing import Optional
from dataclasses import dataclass


class User(UserMixin):
    user_id: int = -1
    full_name: str = ''
    email: str = ''
    password: str = ''

    def __init__(self, user_id=-1, full_name='', email='', password=''):
        self.user_id = user_id
        self.full_name = full_name
        self.email = email
        self.password = password

    def get_id(self) -> str:
        return str(self.user_id)

    def is_authenticated(self) -> bool:
        return True

    def is_active(self) -> bool:
        return True

    def is_anonymous(self) -> bool:
        return False


@dataclass
class Address:
    address_id: int = -1
    st_address1: str = ''
    st_address2: str = ''
    city: str = ''
    state: str = ''
    zip: str = ''
    user_id: int = -1


@dataclass
class Phone:
    ph_number: str = ''
    is_primary: bool = False
    user_id: int = -1


@dataclass
class Order:
    order_id: int = -1
    order_date: str = ''
    total_price: float = -1.0
    user_id: int = -1


@dataclass
class Product:
    product_id: int = -1
    name: str = ''
    price: float = -1.0
    weight: float = -1.0
    short_desc: str = ''
    category_id: int = -1
    supplier_id: int = -1
    long_desc: Optional[str] = None
    image_url: Optional[str] = None


@dataclass
class Category:
    category_id: int = -1
    category_name: str = ''


@dataclass
class Supplier:
    supplier_id: int = -1
    company_name: str = ''
    contact_first_name: str = ''
    contact_last_name: str = ''
    contact_title: str = ''
    address_id: int = -1


@dataclass
class OrderProduct:
    order_id: int = -1
    product_id: int = -1
    quantity: int = -1
